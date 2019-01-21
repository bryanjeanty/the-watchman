class Avatar

    def initialize(first_name, last_name)
        @name = "name=#{ first_name }+#{ last_name }"
        @base_uri="ui-avatars.com/api/"
        @bg_colors = [
            "cc0000",
            "cc6600",
            "269900",
            "0066cc",
            "9900cc"
        ]
        @background = @bg_colors.sample
    end

    def get_avatar_url
        "https://#{ @base_uri }?#{ @name }&background=#{ @background }&color=fff&size=128&font-size=0.65"
    end
end