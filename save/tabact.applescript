on run argv
	tell application "Brave Browser"
		repeat with w in (windows)
			set j to 0
			repeat with t in (tabs of w)
				set j to j + 1
				if title of t contains (item 1 of argv) then
					set (active tab index of w) to j
					return
				end if
			end repeat
		end repeat
	end tell
end run