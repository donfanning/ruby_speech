module RubySpeech
  module SSML
    class Element < Niceogiri::XML::Node
      def self.new(element_name, atts = {}, &block)
        super(element_name).tap do |new_node|
          atts.each_pair { |k, v| new_node.send :"#{k}=", v }
          block_return = new_node.instance_eval &block if block_given?
          new_node << new_node.encode_special_chars(block_return) if block_return.is_a?(String)
        end
      end

      def method_missing(method_name, *args, &block)
        const_name = method_name.to_s.sub('ssml', '').titleize.gsub(' ', '')
        const = SSML.const_get const_name
        if const && self.class::VALID_CHILD_TYPES.include?(const)
          if const == String
            self << encode_special_chars(args.first)
          else
            self << const.new(*args, &block)
          end
        else
          super
        end
      end

      def eql?(o, *args)
        super o, :content, *args
      end
    end # Element
  end # SSML
end # RubySpeech
