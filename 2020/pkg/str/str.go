package str

// CountCharactersInString counts the number of a certain character in a string
func CountCharactersInString(value string, character string) int {
	count := 0
	for _, c := range value {
		if string(c) == character {
			count++
		}
	}
	return count
}
