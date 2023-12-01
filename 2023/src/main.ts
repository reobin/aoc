import fs from 'fs';
import path from 'path';
import NumberHelper from './helpers/number';

const dayInput = process.argv[2];
if (typeof dayInput === 'undefined') {
  console.error('Please provide a day number');
  process.exit(1);
}
if (Number.isNaN(Number(dayInput))) {
  console.error('Please provide a valid day number');
  process.exit(1);
}

const day = Number(dayInput);
if (day < 1 || day > 25) {
  console.error('Please provide a day between 1 and 25');
  process.exit(1);
}

const formattedDay = NumberHelper.pad(day, 2);
const dayModule = require(`./day${formattedDay}`);

const input = fs.readFileSync(
  path.join(__dirname, `../input/day${formattedDay}.txt`),
  'utf8',
);

console.log('# Part 1');
const resultPart1 = dayModule.part1(input);
console.log(resultPart1);

console.log('# Part 2');
const resultPart2 = dayModule.part2(input);
console.log(resultPart2);
