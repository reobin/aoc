import fs from 'fs';
import path from 'path';

import SystemHelper from './helpers/system';

async function run() {
  const day = SystemHelper.getDay();
  if (day === null) {
    process.exit(1);
  }

  const input = fs.readFileSync(
    path.join(__dirname, `../input/day${day}.txt`),
    'utf8',
  );

  const dayModule = await import(`./days/day${day}`);

  console.log('# Part 1');
  const resultPart1 = dayModule.default.part1(input);
  console.log(resultPart1);

  console.log('# Part 2');
  const resultPart2 = dayModule.default.part2(input);
  console.log(resultPart2);
}

run();
