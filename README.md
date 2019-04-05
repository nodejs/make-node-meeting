# make-node-meeting

**Generate a text for a GitHub issue announcing a Node.js working group meeting**

[![NPM](https://nodei.co/npm/make-node-meeting.png)](https://nodei.co/npm/make-node-meeting/)

## Up and Running: Installation and Usage

To get started with `make-node-meeting` install the tool globally:

```bash
npm install make-node-meeting -g
```

Next, make sure `coreutils` is installed (macOS):
```
brew install coreutils
```

Once the dependencies are installed, create a new directory to hold the config for the meeting you want to generate:
```
mkdir ~/.make-node-meeting
```

Create a new `.sh` file in this directory to hold your meeting configuration:
```
touch ~/.make-node-meeting/<meetingname>.sh # Where <meetingname> is the name of the group or WG you want to create a meeting for.
```

Once this file is created, open it in your editor of choice add a configuration. There are several [example configurations](./exmaples) in this repo.

When the configuration is added, run the following command:
```
make-node-meeting <meetingname> # Where <meetingname> is the name of the group or WG you want to create a meeting for
```

Fill out the questions it asks as appropriate for your specific case. Once complete, `make-node-meeting` will output the Markdown source into your terminal - copy and paste it into your issue and you should be ready to go!


## Configuration
Given a working group "code", produce Markdown-formatted issue text for that working group. The code is used to load a configuration file as `~/.make-node-meeting/code.sh` which contains settings required for customising the text.

The configuration file must contain:

```sh
GROUP_NAME="Name of Group"
MEETING_TIME="UTC day and time"
INVITEES="Markdown list of invitees"
JOINING_INSTRUCTIONS="Specific instructions on how to join"
```

The configuration file can optionally contain:

```sh
GITHUB_ORG="openjs-foundation"
HOST="OpenJS Foundation"
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
