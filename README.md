# DivvyDough
## Inspiration
Let's say you're travelling with a group of friends.

- First, you book an Airbnb to share among your group. No big deal; just ask everyone to pay you back one by one.
- Then, you rent a Zipcar. No big deal; just ask everyone to pay you back one by one.
- You Zipcar to a restaurant, and cover the group's bill to save time. No big deal; just ask everyone to pay you back one by one...

Doesn't that get tedious?

## What it does
DivvyDough is an app that lets you avoid all this by essentially having everyone to split bills beforehand. As a "leader" of the group you're travelling with, here's how DivvyDough works for you:

1. **Discuss and agree on a budget with your friends.** Since you will be group-spending on a lot of the same stuff, agreeing on a budget for the trip is a good idea.
2. **Have your friends transfer you the budgeted amount before the trip starts.** As group leader, you will have access to the group's funds, and there will be no need to chase people down. These funds will be transferred directly to your bank account.
3. **When it's time to group-spend, cover it for the group.** You will have enough in your account unless you are severely over-budget.
4. **Charge your friends on DivvyDough.** Mark the group spending in the app, and your friends will be notified of the charge.
5. **Refund any unspent balance.** Unless your group is over-budget, you will still hold some of your friends' funds at the end of the trip. Refund it back to their bank accounts when the trip is finished.

## How we built it
We built DivvyDough for iOS in Swift to take full advantage of the OS's features. Our backend is built with Express.js in Node.

## Accomplishments that we're proud of
Our demo app effectively demonstrates the concept and purpose of the app. Hopefully you want to use an app like this as much as we want to make it!

## Challenges we ran into
It is, however, difficult to design and implement a UI in such a short time that a user can intuitively use, and infer the app's purpose without an explanation. If you open the app and don't know what it's supposed to do, maybe that will change with further development.

## What we learned
As our team's first proper attempt at a submission to a hackathon, we learned that teamwork is the most important thing at an event like this. We found it difficult to implement as many features as we wanted to as a two-person team, and found that we might have been able to do much more if we had additional manpower.

## What's next for DivvyDough
As a project created within 36 hours, DivvyDough still needs a lot of work:
- **DivvyDough is meant to be integrated with banks.** We had intended to use Capital One and PayPal APIs to transfer money between accounts, but ran out of time.
- **Push notifications would greatly improve the UX.** Ideally, the group leader receives a notification when he/she spends anything from her bank account during the trip, which he/she can tap into and charge the group back for. Then, all group members ideally receive a notification for the charge.
- **DivvyDough only works in USD.** There is work to be done to include support for international trips.
