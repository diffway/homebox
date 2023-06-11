# Sieve script to report jumk email (spam) by moving an email into the spam folder

require [
  "vnd.dovecot.pipe",
  "vnd.dovecot.execute",
  "copy",
  "imapsieve",
  "environment",
  "variables"
];

if environment :matches "imap.mailbox" "*" {
  set "mailbox" "${1}";
}

# Mark the message as spam when moved into the Junk folder
if string :is "${mailbox}" "Junk" {
  execute :pipe "learn-hamorspam.sh" [ "spam" ];
  stop;
}
