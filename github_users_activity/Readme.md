Specle Developer Exercise
The purpose of this exercise is to use the Github public API to find a given list of users’ total number of public commits over the
past year and rank them accordingly.
The program will take a comma-separated list of Github usernames from standard input, make the relevant calls to the Github
API then present the results in a list of username -> commit mappings, ordered by commit counts. Note that for each repo, we’re
interested in just the owner’s commits, not the commits of everybody with access to the repo.
Feel free to use any third party libraries you like.
Example
Notes
Without authentication, the Github API is rate limited to 60 requests per hour. We suggest authorising your API calls with an
OAuth token.
Submission
Please submit an executable solution with all source files in a common archive format (zip, tar, etc.)
Relevant documentation
http://developer.github.com/v3/repos/#list-your-repositories
http://developer.github.com/v3/repos/statistics/#get-the-weekly-commit-count-for-the-repo-owner-and-everyone-else
