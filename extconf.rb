require 'mkmf'

mecab_config = with_config('mecab-config', 'mecab-config')
use_mecab_config = enable_config('mecab-config')

`mecab-config --libs-only-l`.chomp.split.each { | lib |
  have_library(lib)
}

$CFLAGS += ' ' + `#{mecab_config} --cflags`.chomp

case RUBY_PLATFORM
when /darwin/
  $LDFLAGS = '-L/opt/local/lib'
when /linux/
  $LDFLAGS = '-L/usr/local/lib'
end

have_header('mecab.h') && create_makefile('MeCab')
