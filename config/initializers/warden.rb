require "passcode_strategy"

Warden::Strategies.add(:passcode, PasscodeStrategy)
