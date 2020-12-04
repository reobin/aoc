package day

import "testing"

func TestRunDay04(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in`

		answerPart1, answerPart2 := RunDay04(input)

		if answerPart1 != "2" {
			t.Errorf("Incorrect result for RunDay04 (part 1), got: %s, want: %s", answerPart1, "2")
		}

		if answerPart2 != "2" {
			t.Errorf("Incorrect result for RunDay04 (part 2), got: %s, want: %s", answerPart2, "2")
		}
	})

	t.Run("sample test invalid part 2", func(t *testing.T) {
		input := ` eyr:1972 cid:100
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007`

		_, answerPart2 := RunDay04(input)

		if answerPart2 != "0" {
			t.Errorf("Incorrect result for RunDay04 (part 2), got: %s, want: %s", answerPart2, "0")
		}
	})

	t.Run("sample test valid part 2", func(t *testing.T) {
		input := `pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719`

		_, answerPart2 := RunDay04(input)

		if answerPart2 != "4" {
			t.Errorf("Incorrect result for RunDay04 (part 2), got: %s, want: %s", answerPart2, "4")
		}
	})
}

func TestIsFieldValueValid(t *testing.T) {
	t.Run("byr", func(t *testing.T) {
		valid := "2002"
		invalid := "2003"

		if !isFieldValueValid("byr", valid) {
			t.Errorf("Incorrect result for isFieldValueValid (byr), got false for %s", valid)
		}

		if isFieldValueValid("byr", invalid) {
			t.Errorf("Incorrect result for isFieldValueValid (byr), got true for %s", invalid)
		}
	})

	t.Run("hgt", func(t *testing.T) {
		valid1 := "60in"
		valid2 := "190cm"
		invalid1 := "190in"
		invalid2 := "190"

		if !isFieldValueValid("hgt", valid1) {
			t.Errorf("Incorrect result for isFieldValueValid (hgt), got false for %s", valid1)
		}

		if !isFieldValueValid("hgt", valid2) {
			t.Errorf("Incorrect result for isFieldValueValid (hgt), got false for %s", valid2)
		}

		if isFieldValueValid("hgt", invalid1) {
			t.Errorf("Incorrect result for isFieldValueValid (hgt), got true for %s", invalid1)
		}

		if isFieldValueValid("hgt", invalid2) {
			t.Errorf("Incorrect result for isFieldValueValid (hgt), got true for %s", invalid2)
		}
	})

	t.Run("hcl", func(t *testing.T) {
		valid1 := "#123abc"
		invalid1 := "#123abz"
		invalid2 := "123abc"

		if !isFieldValueValid("hcl", valid1) {
			t.Errorf("Incorrect result for isFieldValueValid (hcl), got false for %s", valid1)
		}

		if isFieldValueValid("hcl", invalid1) {
			t.Errorf("Incorrect result for isFieldValueValid (hcl), got true for %s", invalid1)
		}

		if isFieldValueValid("hcl", invalid2) {
			t.Errorf("Incorrect result for isFieldValueValid (hcl), got true for %s", invalid2)
		}
	})

	t.Run("hcl", func(t *testing.T) {
		valid1 := "brn"
		invalid1 := "wat"

		if !isFieldValueValid("ecl", valid1) {
			t.Errorf("Incorrect result for isFieldValueValid (ecl), got false for %s", valid1)
		}

		if isFieldValueValid("ecl", invalid1) {
			t.Errorf("Incorrect result for isFieldValueValid (ecl), got true for %s", invalid1)
		}
	})

	t.Run("pid", func(t *testing.T) {
		valid1 := "000000001"
		invalid1 := "0123456789"

		if !isFieldValueValid("pid", valid1) {
			t.Errorf("Incorrect result for isFieldValueValid (pid), got false for %s", valid1)
		}

		if isFieldValueValid("pid", invalid1) {
			t.Errorf("Incorrect result for isFieldValueValid (pid), got true for %s", invalid1)
		}
	})
}
