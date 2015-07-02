requires 'perl', '5.008001';
requires 'JSON';
requires 'List::MoreUtils';
requires 'Exporter';
requires 'parent';

on test => sub {
    requires 'Test::JSON';
    requires 'Test::More', '0.98';
};
