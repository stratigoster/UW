type pointer is access integer;
px : pointer;
x : integer := px; -- automatic dereferencing
py : pointer := px; -- no dereferencing here
