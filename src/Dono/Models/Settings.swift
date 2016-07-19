// Dono OS X - Password Derivation Tool
// Copyright (C) 2016  Dono - Password Derivation Tool
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import Foundation

class Settings
{
    var REMEMBER_KEY_KEY = "rememberKey"
    
    internal func getRememberKeyValue() -> Bool
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        return defaults.boolForKey(REMEMBER_KEY_KEY)
    }
    
    internal func setRememberKeyValue(value: Bool)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(value, forKey: REMEMBER_KEY_KEY)
    }
}