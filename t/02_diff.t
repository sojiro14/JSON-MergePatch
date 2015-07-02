use strict;
use warnings;
use Test::More;

use JSON::MergePatch;

my $test_cases = +[
    +{ source => '{"a":"c"}',         target => '{"a":"b"}',               expected => {'a'=>'c'} },
    +{ source => '{"a":"b","b":"c"}', target => '{"a":"b"}',               expected => {'b'=>'c'} },
    +{ source => '{}',                target => '{"a":"b"}',               expected => {'a'=>undef} },
    +{ source => '{"b":"c"}',         target => '{"a":"b","b":"c"}',       expected => {'a'=>undef} },
    +{ source => '{"a":"c"}',         target => '{"a":["b"]}',             expected => {'a'=>'c'} },
    +{ source => '{"a":["b"]}',       target => '{"a":"c"}',               expected => {'a'=>['b']} },
    +{ source => '{"a":{"b":"d"}}',   target => '{"a":{"b":"c"}}',         expected => {'a'=>{'b'=>'d'}} },
    +{ source => '{"a":{"b":"d"}}',   target => '{"a":{"b":"c","c":"d"}}', expected => {'a'=>{'b'=>'d','c'=>undef}} },
    +{ source => '{"a":[1]}',         target => '{"a":"b"}',               expected => {'a'=>[1]} },
    +{ source => '["c","d"]',         target => '["a","b"]',               expected => ['c','d'] },
    +{ source => '["c"]',             target => '{"a":"b"}',               expected => ['c'] },
    +{ source => undef,               target => '{"a":"foo"}',             expected => undef },
    +{ source => 'bar',               target => '{"a":"foo"}',             expected => 'bar' },
    +{ source => '{"e":null,"a":1}',  target => '{"e":null}',              expected => {'a'=>1} },
    +{ source => '{"a":"b"}',         target => '[1,2]',                   expected => {'a'=>'b'} },
    +{ source => '{"a":{"bb":{}}}',   target => '{}',                      expected => {'a'=>{'bb'=>{}}} },
    +{ source => '{"a":{"bb":{}}}',   target => undef,                     expected => {'a'=>{'bb'=>{}}} },
];

for my $test_case (@$test_cases) {
    is_deeply (JSON::MergePatch->diff($test_case->{source}, $test_case->{target}), $test_case->{expected});
    is_deeply (json_merge_diff($test_case->{source}, $test_case->{target}), $test_case->{expected});
}

done_testing;
