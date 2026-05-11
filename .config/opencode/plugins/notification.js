export const NotificationPlugin = async ({
  project,
  client,
  $,
  directory,
  worktree,
}) => {
  const titleCache = new Map();

  const sessionEvents = {
    "session.created": "Session started",
    "session.idle": "Session done",
    "session.error": "Session error",
  };

  async function getTitle(event) {
    if (
      event.type === "session.created" ||
      event.type === "session.updated"
    ) {
      const title = event.properties.info.title;
      titleCache.set(event.properties.info.id, title);
      return title;
    }

    const sessionID = event.properties?.sessionID;
    if (!sessionID) return "unknown";

    if (titleCache.has(sessionID)) {
      return titleCache.get(sessionID);
    }

    try {
      const res = await client.session.get({ path: { id: sessionID } });
      const title = res.data?.title || sessionID;
      titleCache.set(sessionID, title);
      return title;
    } catch {
      return sessionID;
    }
  }

  return {
    event: async ({ event }) => {
      const label = sessionEvents[event.type];
      if (label) {
        const title = await getTitle(event);
        const safeTitle = title.replace(/["\\]/g, "");
        const safeLabel = label.replace(/["\\]/g, "");
        const worktreeName = worktree.split("/").filter(Boolean).pop() || worktree;
        const safeWorktree = worktreeName.replace(/["\\]/g, "");
        await $`osascript -e ${`display notification "${safeTitle}" with title "opencode [${safeWorktree}]" subtitle "${safeLabel}"`}`;
      }
    },
  };
};
