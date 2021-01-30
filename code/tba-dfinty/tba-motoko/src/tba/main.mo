actor TBA {
    stable var tba_msg = "The Big Announcement";

    public func set_message(msg : Text) : async Text {
        tba_msg := msg;
        return "Hello, " # tba_msg # "!";
    };

    public func set_message_no_return(msg : Text) {
        tba_msg := msg;        
    };

    public func loading_message() : async Text {
        return tba_msg;
    };
};


