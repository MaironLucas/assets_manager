# Asset Manager

A app based to fit the Tractian Mobile challenge.

## What would I improve if I had more time?
- Refine all the code in the repository to improve performance and readability. Maybe the first 
thing I would do is sort the response obtained from the /assets endpoint in some way, so the 
recursive method could find its parent more easily.
- Implement a caching system to store the assets tree. I could probably use a package like Hive for this.
- Refine the app theme system to configure all colors and text styles in a single place.
- Implement all parts of Clean Architecture. To reduce development time, I omitted the domain layer 
and used only a repository to handle the data.