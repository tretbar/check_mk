 This check monitors the number of deferred mails in the outgoing zimbra mail
 queue, as sent by the zimbra_mailq plugin.

 This check creates one service per host which represents the state
 of the mailqueues.

 The check will result in WARNING/CRITICAL states when the number of items
 in the queues have reached the defined thresholds.
