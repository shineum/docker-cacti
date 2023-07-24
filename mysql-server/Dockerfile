FROM mysql:8.0.33

# DB config
RUN touch /etc/mysql/conf.d/mysql.cnf
RUN echo "[mysqld]" >> /etc/mysql/conf.d/mysql.cnf
RUN echo "collation_server = utf8mb4_unicode_ci" >> /etc/mysql/conf.d/mysql.cnf
RUN echo "max_heap_table_size = 200M" >> /etc/mysql/conf.d/mysql.cnf
RUN echo "tmp_table_size = 200M" >> /etc/mysql/conf.d/mysql.cnf
RUN echo "innodb_buffer_pool_size = 3000M" >> /etc/mysql/conf.d/mysql.cnf
# RUN echo "innodb_doublewrite = ON" >> /etc/mysql/conf.d/mysql.cnf
RUN echo "innodb_flush_log_at_timeout = 3" >> /etc/mysql/conf.d/mysql.cnf
RUN echo "innodb_read_io_threads = 32" >> /etc/mysql/conf.d/mysql.cnf
RUN echo "innodb_write_io_threads = 16" >> /etc/mysql/conf.d/mysql.cnf
RUN echo "innodb_io_capacity = 5000" >> /etc/mysql/conf.d/mysql.cnf
RUN echo "innodb_io_capacity_max = 10000" >> /etc/mysql/conf.d/mysql.cnf

COPY ./mysql-server/docker-init-mysql.sh .
