// https://adventofcode.com/2020/day/4#part2
/*
--- Part Two ---

The line is moving more quickly now, but you overhear airport security talking about how passports with invalid data are getting through. Better add some data validation, quick!

You can continue to ignore the cid field, but each other field has strict rules about what values are valid for automatic validation:

    byr (Birth Year) - four digits; at least 1920 and at most 2002.
    iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    hgt (Height) - a number followed by either cm or in:
        If cm, the number must be at least 150 and at most 193.
        If in, the number must be at least 59 and at most 76.
    hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    pid (Passport ID) - a nine-digit number, including leading zeroes.
    cid (Country ID) - ignored, missing or not.

Your job is to count the passports where all required fields are both present and valid according to the above rules. Here are some example values:

byr valid:   2002
byr invalid: 2003

hgt valid:   60in
hgt valid:   190cm
hgt invalid: 190in
hgt invalid: 190

hcl valid:   #123abc
hcl invalid: #123abz
hcl invalid: 123abc

ecl valid:   brn
ecl invalid: wat

pid valid:   000000001
pid invalid: 0123456789

Here are some invalid passports:

eyr:1972 cid:100
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007

Here are some valid passports:

pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719

Count the number of valid passports - those that have all required fields and valid values. Continue to treat cid as optional. In your batch file, how many passports are valid?
*/

import "io" for File

class Passport {
  raw {_raw}
  line {_line}
  debug {false}
  debug(message) {
    if (debug) {
      System.print(message)
    }
  }

  construct new(raw) {
    _raw = raw
    _line = raw.split("\n").join(" ")
  }

  valid() {

    // Optional
    var cid = line.indexOf("cid:")

    var byr = line.indexOf("byr:")
    var iyr = line.indexOf("iyr:")
    var eyr = line.indexOf("eyr:")
    var hgt = line.indexOf("hgt:")
    var hcl = line.indexOf("hcl:")
    var ecl = line.indexOf("ecl:")
    var pid = line.indexOf("pid:")


    debug("Checking")
    debug(line)

    // Check required fields
    if (!(byr >= 0 &&
      iyr >= 0 &&
      eyr >= 0 &&
      hgt >= 0 &&
      hcl >= 0 &&
      ecl >= 0 &&
      pid >= 0)) {
      debug("Missing fields " + {
        "byr": byr,
        "iyr": iyr,
        "eyr": eyr,
        "hgt": hgt,
        "hcl": hcl,
        "ecl": ecl,
        "pid": pid}.toString)
      return false
    }


    debug("Contains required fields")

    var birth = Num.fromString(line[byr + 4..line.indexOf(" ", byr)].trim())
    debug("Checking Birth Year %(birth)")
    if (birth < 1920 || birth > 2002) {
      debug("Invalid Birth Year %(birth)")
      return false
    }

    debug("Birth Year %(birth) is >= 1920 && <= 2002")

    var issue = Num.fromString(line[iyr + 4..line.indexOf(" ", iyr)].trim())
    debug("Checking issue %(issue)")
    if (issue < 2010 || issue > 2020) {
      debug("Invalid issue %(issue)")
      return false
    }

    debug("Issue %(issue) is >= 2010 && <= 2020")

    var expiration = Num.fromString(line[eyr + 4..line.indexOf(" ", eyr)].trim())
    debug("Checking Expiration %(expiration)")
    if (expiration < 2020 || expiration > 2030) {
      debug("Invalid Expiration %(expiration)")
      return false
    }

    debug("Expiration %(expiration) is >= 2020 && <= 2030")

    var height = line[hgt + 4..line.indexOf(" ", hgt)]

    debug("Checking Height %(height)")

    var measure = height.indexOf("cm")
    if (measure < 0) {
      measure = height.indexOf("in")
    }

    if (measure < 0) {
      debug("Invalid measure")
      return false
    }

    debug("Height %(height) measure is cm or in")

    var heightnum = Num.fromString(height[0...measure])
    if (!heightnum) {
      debug("Invalid height value")
      return false
    }

    measure = height[measure...height.count].trim()

    debug("Checking measure %(measure)")

    if (!(measure == "cm" || measure == "in")) {
      debug("Unknown measure %(measure)")
      return false
    }

    if (measure == "cm") {
      debug("Checking cm")
      if (heightnum < 150 || heightnum > 193) {
        debug("Height %(heightnum) is invalid")
        return false
      }

      debug("Height %(heightnum) (cm) is >= 150 && <= 193")
    }

    if (measure == "in") {
      debug("Checking in")
      if (heightnum < 59 || heightnum > 76) {
        debug("Height %(heightnum) is invalid")
        return false
      }

      debug("Height %(heightnum) (in) is >= 59 && <= 76")
    }

    var hair = line[hcl + 4..line.indexOf(" ", hcl)].trim()
    debug("Checking hair %(hair)")
    if (hair[0] != "#" || hair.count != 7) {
      debug("Invalid hair %(hair)")
      return false
    }

    debug("Hair %(hair) starts with # and total length is 7 (including #)")

    var validchars = [
      "0", "1", "2", "3",
      "4", "5", "6", "7",
      "8", "9", "a", "b", "c",
      "d", "e", "f", "#"
    ]

    hair.each{|char|
      if (!validchars.contains(char)) {
        debug("Unkown char %(char)")
        return false
      }
    }

    debug("Hair %(hair) have valid chars")

    var eye = line[ecl + 4..line.indexOf(" ", ecl)].trim()
    var eyecolors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

    debug("Checking Eye Color %(eye)")

    if (!eyecolors.contains(eye)) {
      debug("Invalid eye color %(eye)")
      return false
    }

    debug("Eye color %(eye) is valid")

    var passid = line[pid + 4..line.indexOf(" ", pid)].trim()
    debug("Checking Passport id %(passid)")
    if (!Num.fromString(passid) || passid.count != 9) {
      debug("Invalid Passport id %(passid)")
      return false
    }

    debug("Passport id is Valid")

    debug("VALID: %(line)")
    return true
  }

  static valid(item) {Passport.new(item).valid()}
}

var valids = 0
File.read("./day/4/input.txt").trim().split("\n\n").each {|item|
  if (Passport.valid(item)) {
    valids = valids + 1
  }
}

// 103
System.print("Answer: " + valids.toString)
