# java thread dumps

- configures automated thread dumps for java via cron and BASH

## supported platforms

- CentOS

## Module Variables

- Class vars/Hiera Vars
- log_directory/java_thread_dumps_log_directory:  defaults to "/var/log/thread_dumps/", where the thread dumps will be stored
- retention_days/java_thread_dumps_retention_days: defaults to "7", number of days to keep thread dumps for
- dump_mode/java_thread_dumps_dump_mode: defaults to "744", controls the file permissions on each thread dumps
- process/java_thread_dumps_process: defaults to "tomcat_juli", string used for searching for the pid of the process to be dumped
- user/java_thread_dumps_user: defaults to "tomcat", User to run the dumps as

## Manages

- thread_dumps.sh: controls log retention and executes the thread dumps
- cron: controls when and who does the thread dump

## Role Dependencies

- n/a 

## License

- MIT

## Author Information

- Tony Welder
- tony.wvoip@gmail.com
