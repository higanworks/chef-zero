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
require 'redis'

module ChefZero
  module DataStore
    class RedisStore < ChefZero::DataStore::InterfaceV2
      def initialize
        clear
      end

      attr_reader :data

      def clear
      end

      def create_dir(path, name, *options)
      end

      def create(path, name, data, *options)
      end

      def get(path, request=nil)
      end

      def set(path, data, *options)
      end

      def delete(path)
      end

      def delete_dir(path, *options)
      end

      def list(path)
      end

      def exists?(path, options = {})
      end

      def exists_dir?(path)
      end
    end
  end
end
