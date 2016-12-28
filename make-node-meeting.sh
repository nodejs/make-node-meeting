#!/bin/bash

# only works on Linux or OSX with coreutils installed

# if running OSX with coreutils installed
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
__dirname="$(CDPATH= cd "$(dirname "$(realpath ${BASH_SOURCE[0]})")" && pwd)"


function print_usage_and_exit {
cat << EOF
Usage: make-node-meeting.sh <group-code>

Where <group-code> exists as ~/.make-node-meeting/group-code.sh
which contains the following configuration for that group:
  GROUP_NAME="Name of Group"
  MEETING_TIME="UTC day and time"
  INVITEES="Markdown list of invitees"
  JOINING_INSTRUCTIONS="Specific instructions on how to join"
e.g.
  GROUP_NAME="Core Technical Committee (CTC)"
  MEETING_TIME="Wednesday 8pm"
  INVITEES="
  * @bnoordhuis (CTC)
  * @chrisdickinson (CTC)
  ...
  "
  JOINING_INSTRUCTIONS="Uberconference; participants should have the link & numbers."
EOF
  exit 1
}

if [ "$1" == "" ]; then
  print_usage_and_exit
fi

GROUP_CODE=$1

. ~/.make-node-meeting/${GROUP_CODE}.sh

if [ "X${GROUP_NAME}" == "X" ] || [ "X${MEETING_TIME}" == "X" ] || [ "X${INVITEES}" == "X" ] || [ "X${JOINING_INSTRUCTIONS}" == "X" ]; then
  print_usage_and_exit
fi

meeting_date=$(TZ=UTC date --date="$MEETING_TIME" --rfc-3339=seconds)
common_fmt="%a %d-%b-%Y %R (%I:%M %p)"
utc_short=$(TZ=UTC date --date="$meeting_date" +"%F")

echo -n "Previous Meeting Minutes Google Docs URL: "
read prev_doc_url
echo -n "This Meeting Minutes Google Docs URL: "
read curr_doc_url

cat << EOF

Node.js Foundation $GROUP_NAME Meeting $utc_short

--------------------------------------

## Time

**UTC $(TZ=UTC date --date="$meeting_date" +"$common_fmt")**:

| Timezone      | Date/Time             |
|---------------|-----------------------|
| US / Pacific  | $(TZ=US/Pacific date --date="$meeting_date" +"$common_fmt") |
| US / Mountain | $(TZ=US/Mountain date --date="$meeting_date" +"$common_fmt") |
| US / Central  | $(TZ=US/Central date --date="$meeting_date" +"$common_fmt") |
| US / Eastern  | $(TZ=US/Eastern date --date="$meeting_date" +"$common_fmt") |
| Amsterdam     | $(TZ=Europe/Amsterdam date --date="$meeting_date" +"$common_fmt") |
| Moscow        | $(TZ=Europe/Moscow date --date="$meeting_date" +"$common_fmt") |
| Chennai       | $(TZ=Asia/Kolkata date --date="$meeting_date" +"$common_fmt") |
| Tokyo         | $(TZ=Asia/Tokyo date --date="$meeting_date" +"$common_fmt") |
| Sydney        | $(TZ=Australia/Sydney date --date="$meeting_date" +"$common_fmt") |

Or in your local time:
* http://www.timeanddate.com/worldclock/fixedtime.html?msg=Node.js+Foundation+$(node -p 'encodeURIComponent("'"${GROUP_NAME}"'")')+Meeting+${utc_short}&iso=$(TZ=UTC date --date="$meeting_date" +"%Y%m%dT20")
* or http://www.wolframalpha.com/input/?i=8pm+UTC%2C+$(TZ=UTC date --date="$meeting_date" +"%b+%d%%2C+%Y")+in+local+time

## Links

* **Minutes Google Doc**: <${curr_doc_url}>
* _Previous Minutes Google Doc: <${prev_doc_url}>_

## Agenda

Extracted from **${GROUP_CODE}-agenda** labelled issues and pull requests from the **nodejs org** prior to the meeting.

`node ${__dirname}/node-meeting-agenda.js ${GROUP_CODE}-agenda`

## Invited

$INVITEES

## Notes

The agenda comes from issues labelled with \`${GROUP_CODE}-agenda\` across **all of the repositories in the nodejs org**. Please label any additional issues that should be on the agenda before the meeting starts.

## Joining the meeting

$JOINING_INSTRUCTIONS

EOF
