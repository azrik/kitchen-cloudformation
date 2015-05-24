# -*- encoding: utf-8 -*-
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "kitchen/logging"

module Kitchen

  module Driver

    class Cf

      # A class for encapsulating the stack payload logic
      #
      class StackGenerator

        include Logging

        attr_reader :config, :cf

        def initialize(config, ec2)
          @config = config
          @cf = cf
        end

        # Transform the provided config into the hash to send to AWS.  Some fields
        # can be passed in null, others need to be ommitted if they are null
        def cf_stack_data # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
          s = {
            :stack_name                   => config[:stack_name],
            :disable_rollback             => config[:disable_rollback],
            :timeout_in_minutes           => config[:timeout_in_minutes]
          }
          s[:template_url] = config[:template_url] if config[:template_file]
          if config[:template_file]
            s[:template_body] = File.open(config[:template_file], 'rb') { |file| file.read }
          end
          s['Parameters'] = config[:parameters] if config[:parameters]
          end
          s
        end

      end

    end

  end

end
