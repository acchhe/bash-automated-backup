# Bash Automated Backup

A Bash script that packages recently modified entries from a source directory into a timestamped `.tar.gz` archive. It was completed as a final project for an IBM course on Coursera using the course-provided starter script.

## Requirements

- Ubuntu or a compatible Linux environment such as Ubuntu on WSL
- Bash, GNU Coreutils (`date` and `mv`), GNU tar, and gzip
- An existing, readable source directory and an existing, writable destination directory. The script also needs write access to the source because it creates the archive there before moving it.

## Try it

From the repository directory, run the following in Bash:

```bash
mkdir -p source backups
printf 'Backup example\n' > source/example.txt
bash ./backup.sh source backups
ls -l backups/
```

The archive name has the form `backup-<Unix timestamp>.tar.gz`. To list its contents, run `tar -tzf` with the archive's path.

Run the command manually or use an external scheduler such as cron with absolute paths. On WSL, scheduled runs depend on the distribution and cron service being active at the scheduled time.

## Scope and limitations

- The script compares the modification time of each visible top-level entry with the 24-hour cutoff. It includes a selected directory recursively, including its hidden contents. A change to a nested file alone may leave the top-level directory's modification time unchanged and therefore be missed.
- The rolling time window is independent of prior runs. Runs may overlap or leave gaps. The script does not track deletions, verify archives, or remove old archives.
- If no entries qualify, GNU tar refuses to create an empty archive. The script does not handle that case separately or stop explicitly after an archive creation error.
- The archive name has one-second resolution. Runs started in the same second can collide. Use a destination outside the source directory so earlier archives cannot be selected as input.
