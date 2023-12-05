import DayModule from '@/days/day01';

describe('part 1', () => {
  test('sample', () => {
    const input = `1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet`;

    expect(DayModule.part1(input)).toBe(142);
  });
});

describe('part 2', () => {
  test('sample', () => {
    const input = `two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen`;

    expect(DayModule.part2(input)).toBe(281);
  });
});
