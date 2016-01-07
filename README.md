# make-node-meeting

**Generate a text for a GitHub issue announcing a Node.js working group meeting**

Given a working group "code", produce Markdown-formatted issue text for that working group. The code is used to load a configuration file as `~/.make-node-meeting/code.sh` which contains settings required for customising the text.

The configuration file must contain:

```sh
GROUP_NAME="Name of Group"
MEETING_TIME="UTC day and time"
INVITEES="Markdown list of invitees"
JOINING_INSTRUCTIONS="Specific instructions on how to join"
```

The `MEETING_TIME` is used to work out _when the next meeting should occur_ and print that date and time accordingly, with translations to various world timezomes.

For example, `~/.make-node-meeting/ctc.sh` might contain:

```sh
GROUP_NAME="Core Technical Committee (CTC)"
MEETING_TIME="Wednesday 8pm"
INVITEES="
* @bnoordhuis (CTC)
* @chrisdickinson (CTC)
...
"
JOINING_INSTRUCTIONS="Uberconference; participants should have the link & numbers."
```

Furthermore, [node-meeting-agenda](https://github.com/rvagg/node-meeting-agenda) is used to embed the agenda inline in the text. The group code is used to look up the `code-agenda` label across the `nodejs` GitHub org, e.g. `ctc-agenda`, to find issues and pull requests that need to be on the meeting agenda.

## License

**make-node-meeting** is Copyright (c) 2016 Rod Vagg [@rvagg](https://twitter.com/rvagg) and licensed under the MIT licence. All rights not explicitly granted in the MIT license are reserved. See the included LICENSE.md file for more details.