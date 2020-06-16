# Transactions

A transaction, in the context of a database, is a set of instructions that behave as a unit. In relational databases, transactions are:

- **Atomic**: Transactions provide an "all-or-nothing" proposition: must be fully completed, saved (committed) or completely undone (rolled back). A sale in a retail store database illustrates a scenario which explains atomicity, e.g., the sale consists of an inventory reduction and a record of incoming cash. Both either happen together or do not happen.
- **Consistent**: This term refers to the transaction must not break any database rules (such as foreign keys or field restrictions).
- **Isolated**:
  Before explaining the concept of isolation it is necessary to understand the following concepts:

  - **Dirty Reading**: Occurs when a transaction is allowed to read a row that has been modified by another concurrent transaction but has not yet been committed.
  - **Non-repetible Reading**: Occurs when in the course of a transaction a row is read twice and the values ​​do not match.
  - **Ghost Reading**: Occurs when, during a transaction, two identical queries are executed, and the result set of the second is not equal to the result set of the first.

  Clarified this, now we can define the different types of isolation:

  - **Serializable**: Is the highest level of isolation. Transactions are executed in series (one after another) when they work on the same resource. Read, write and range locks are performed. This means that we have no `ghost`, `dirty` or `non-repeatable` readings.
  - **Repeatable reads**: Read and write locks are performed, but not ranges. Therefore, there may be `ghost` readings.
  - **Read commited**: Write lock are performed. Therefore, there may be `ghost` and `non-repeatable` readings. Allows to read only changes comitted by other transactions.
  - **Unread commited**: It is the lowest level of isolation. It allows `dirty` readings, so a transaction can see changes not yet committed by another transaction.

- **Durability**: Guarantees the persistence of the changes committed by the transaction even in the case of a system failure or power outages. They are stored in non-volatile memory.

## Example

If we take it as a practical example, we can think of a bank transfer. You want to transfer USD 2000 from user A to user B. Here we would have two things to do: subtract USD 2000 from user A and add that amount to user B. If something happened after the A update but before the B update, we would be leaving user A with USD 2000 less and B without this amount added. That is why a transaction in this case is the best option.

```javascript
exports.transfer = async ({ transmitterId, receptorId, amount }) => {
  let transaction = {};
  try {
    transaction = await sequelize.transaction(); // Create transaction

    const transmitter = await Account.findOne({ where: { id: transmitterId } }); // Get transmitter account
    const receptor = await Account.findOne({ where: { id: receptorId } }); // Get transmitter account

    await transmitter.increment('amount', { by: -amount, transaction }); // Decrement amount of transmitter account
    await receptor.increment('amount', { by: amount, transaction }); // Increment amount of transmitter account

    await transaction.commit(); // Commit the transaction
  } catch (err) {
    if (transaction.rollback) await transaction.rollback(); // Rollback the transaction in case of error
    throw err;
  }
};
```

In the successful case the queries made would be the following:

```sql
START TRANSACTION;

SELECT `id`, `mail`, `fullName`, `phone`, `documentNumber`, `amount`, `createdAt`, `updatedAt` FROM `users` AS `users` WHERE `users`.`id` = `A`;

SELECT `id`, `mail`, `fullName`, `phone`, `documentNumber`, `amount`, `createdAt`, `updatedAt` FROM `users` AS `users` WHERE `users`.`id` = `B`;

UPDATE `users` SET `amount`=`amount`+ -2000,`updatedAt`='2019-12-26 19:51:02' WHERE `id` = `A`;

UPDATE `users` SET `amount`=`amount`+ 2000,`updatedAt`='2019-12-26 19:51:02' WHERE `id` = `B`;

COMMIT;
```
