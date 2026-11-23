#!/usr/bin/env bash
# Usage: ./new-meeting.sh [YYYYMMDD]   (default: today)
set -euo pipefail
cd "$(dirname "$0")"
date_id="${1:-$(date +%Y%m%d)}"
iso="${date_id:0:4}-${date_id:4:2}-${date_id:6:2}"
[ -e "$date_id" ] && { echo "$date_id already exists" >&2; exit 1; }
mkdir "$date_id"
cp 20260120/meeting.tex 20260120/external-visitors.csv 20260120/member-attendance.csv "$date_id/"
sed -i "s/\\\\mDate{[^}]*}/\\\\mDate{$iso}/" "$date_id/meeting.tex"
ln -s ../template "$date_id/template"
echo "Created $date_id/ - edit $date_id/meeting.tex"
