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

let docsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;

let labelsfilename = "/.labels";
let pathToServiceTagsFile = docsFolder.stringByAppendingString(labelsfilename);

internal class PersistableLabels
{
    var labels = [String]()
    
    internal func add(label: String) -> String
    {
        let l = self.canonical(label)
        
        if (self.labels.contains(l))
        {
            return String()
        }
        
        self.labels.insert(l, atIndex: self.labels.count)
        self.labels.sortInPlace()
        self.saveLabels()
        
        return l
    }
    
    internal func getAll() -> [String]
    {
        self.loadLabels()
        self.labels.sortInPlace()
        
        return self.labels
    }
    
    internal func getAt(position: Int) -> String
    {
        var ret = String();
        
        for (i, label) in self.labels.enumerate()
        {
            if (i == position)
            {
                ret = label;
            }
        }
        
        return ret;
    }
    
    
    internal func deleteAt(position: Int) -> String
    {
        if (position < 0)
        {
            return String()
        }
        
        let ret = self.labels.removeAtIndex(position);
        
        self.saveLabels();
        
        return ret;
    }
    
    internal func count() -> Int
    {
        return self.labels.count;
    }
    
    internal func canonical(label: String) -> String
    {
        var l = label.lowercaseString
        l = l.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        return l
    }
    
    private func saveLabels()
    {
        var dump = String()
        
        for (_, label) in self.labels.enumerate()
        {
            dump += label + "\n"
        }
        
        do
        {
            try dump.writeToFile(pathToServiceTagsFile, atomically: false, encoding: NSUTF8StringEncoding)
        }
        catch
        {
        }
    }
    
    private func loadLabels()
    {
        do
        {
            self.labels.removeAll()
            
            let labels = try String(contentsOfFile: pathToServiceTagsFile, encoding: NSUTF8StringEncoding).characters.split("\n")
            
            for (_, label) in labels.enumerate()
            {
                self.labels.insert(String(label), atIndex: 0)
            }
            
            self.labels.sortInPlace()
        }
        catch
        {
        }
    }
}