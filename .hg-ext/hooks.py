import re

def add_issue_from_bookmark(ui, repo, **kwargs):
    """
    Adds an issue/bug id in front of the commit message if it doesn't have one.
    We check if commit message has something like CC-NN(N) in front of it where C is a [a-zA-Z] character and N is a decimal number.
    If it doesn't have one, then we take it from the branch/bookmark name.
    """
    commitctx = repo.commitctx
    def updatectx (ctx, error):
        if re.match(r"[a-zA-Z]{2}-\d+\w?:?", ctx.description()):
            # commit already have JIRA issue information
            return commitctx(ctx, error)
        else:
            if repo._activebookmark :
                m = re.match(r"([a-zA-Z-_]+/)?([a-zA-Z]{2}-\d+)([a-zA-Z0-9-_]+)?", repo._activebookmark)
                if not m:
                    return commitctx(ctx, error)
                elif m.group(2):
                    ctx._text = m.group(2).upper() + ': ' + ctx.description()
                    return commitctx(ctx, error)

    repo.commitctx = updatectx


