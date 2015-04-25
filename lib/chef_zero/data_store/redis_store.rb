#
# Copyright:: Copyright (c) 2015 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef_zero/data_store/data_already_exists_error'
require 'chef_zero/data_store/data_not_found_error'
require 'chef_zero/data_store/interface_v2'
require 'chef/json_compat'
require 'redis'

module ChefZero
  module DataStore
    class RedisStore < ChefZero::DataStore::InterfaceV2
      def initialize(opts = {})
        @redis = Redis.new(opts)
        clear
      end

      attr_reader :data

      def clear
      end

      def create_dir(path, name, *options)
        raise_up(self)
      end

      def create(path, name, data, *options)
        hkey = [path, Chef::JSONCompat.parse(data)["chef_type"]].flatten.join("/")
        @redis.hset(hkey, name, data)
      end

      def get(path, request=nil)
        hkey, field = split_path(path)
        @redis.hget(hkey.join("/").chop, field)
      end

      def set(path, data, *options)
        raise_up(self)
      end

      def delete(path)
        raise_up(path)
      end

      def delete_dir(path, *options)
        raise_up(self)
      end

      def list(path)
        @redis.hkeys(path.join("/").chop)
      end

      def exists?(path, options = {})
        raise_up(self)
      end

      def exists_dir?(path)
        raise_up(path)
      end

      private
      def split_path(path)
        [path, path.pop]
      end

      def raise_up(*args)
        raise
      rescue => e
        puts "Raize UP for debug!"
        puts args.to_s
        puts "=========="
        puts e.backtrace
        exit
        # require 'chef_zero'; require 'chef_zero/server'; require 'chef_zero/data_store/redis_store'
        # ChefZero::Server.new(data_store: ChefZero::DataStore::RedisStore.new).start
      end
    end
  end
end
