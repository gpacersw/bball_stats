bball_stats
===========

A few design choices

- stats ETL: could be optimzed to be more efficient and faster.  I marked that as tech debt for later
- sttas ETL: I chose to read in all the data such that if the "client" asks to make changes or add features I would have the MVC already to go
- model: I scaffolded all of the XML data entities mostly normalized for this demo.  For future efficiency, depending on the application features, use cases and work flow could be de-normalized.   
- Routing was simplistic and built quick for demo, could be "made more correct" with more direction from client on future needs
- Not pleased with the app/views/players/index.html.erb @stats_hitters array lookup for each player to get their stats.  With DB de-normalization could be factored out
- UI could have more design to it for future demos
- UI did not have time to add a "season / year picker" for future season, routes are set up for this
- TDD, did not have time to add factories and tests.  Would be first on the list on next sprint
- tablesorter JS is a great lib, very straight forward for pulling over all data at once.

In summary, the short, time boxed effort made for stark design choices, however the results appear to meet the requirements  
