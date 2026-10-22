import type { EngineInterface, Register } from 'claude-code'

// Claude Code only discovers skills under .claude/skills, so mirror .agents/skills there
// with links, and reload skills when the links change.
type Linked = { changes: string } | { error: string }

const linkSkills = async ($: EngineInterface, cwd: string): Promise<Linked> => {
  const ran = await $.process.run(['/bin/sh', `${$.plugin.root}/hooks/link-skills.sh`, cwd], {
    timeoutMs: 10_000,
  })
  return ran.exitCode === 0
    ? { changes: ran.stdout.trim() }
    : { error: ran.stderr.trim() || `exit code ${ran.exitCode}` }
}

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    const started = await next(e)
    await $.command.register({
      name: 'relink-skills',
      description: 'Relink .agents/skills into .claude/skills and reload skills',
    })
    return started
  })

  on('classic.SessionStart', async ($, e, next) => {
    const started = await next(e)
    const linked = await linkSkills($, e.cwd)

    if ('error' in linked) {
      $.ui.log(`${$.plugin.name}: link-skills.sh failed: ${linked.error}`, { to: 'debug' })
      return started
    }
    if (linked.changes === '') return started

    $.ui.log(`${$.plugin.name}:\n${linked.changes}`, { to: 'debug' })
    return { ...started, reloadSkills: true }
  }).catch(($, e, next) => next(e))

  on('command.run', { command: 'relink-skills' }, async $ => {
    const linked = await linkSkills($, await $.session.cwd())
    if ('error' in linked) return { text: `link-skills.sh failed: ${linked.error}` }

    // Queued until this command finishes; awaiting it here would wait on ourselves.
    void $.command.run({ command: 'reload-skills' }).catch(err =>
      $.ui.log(`${$.plugin.name}: /reload-skills failed: ${err}`, { to: 'debug' }),
    )
    const summary = linked.changes === '' ? 'No link changes.' : linked.changes
    return { text: `${summary}\nReloading skills.` }
  })
}
