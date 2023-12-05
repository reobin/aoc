import DayModule from '@/days/day03';

describe('part 1', () => {
  test('sample', () => {
    const input = `467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..`;

    expect(DayModule.part1(input)).toBe(4361);
  });
});

describe('part 2', () => {
  test('sample', () => {
    const input = `467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..`;

    expect(DayModule.part2(input)).toBe(467835);
  });
});
