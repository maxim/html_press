require 'fileutils'

namespace :hpress do
  desc 'Purge HTMLPress cache directory.'
  task(:purge => :environment) do
    FileUtils.rm_r(HTMLPress::Store.path)
  end
end