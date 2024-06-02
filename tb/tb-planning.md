# TB Planning

### Gathering guild member info

Using wookiebot in Discord

`/raid guild`

Download the resulting CSV and save as `allycodes.csv` in the /tb folder.
- Only needs renewing when numerous roster changes in the guild

### Gathering Wookiebot ROTE output

Using wookiebot, generate the 'Assignments as JSON' and download to the `/tb/wookiebot-output` folder. Git Push.

(Future = GH action)

Run `tb-planning-creator.ps1` from the root directory of the repository, having pulled the most recent files.

This will output the data to [Rote Plan](rote-plan.md)



