/* https://adventofcode.com/2023/day/3 */

import NumberHelper from '@/helpers/number';
import PointHelper from '@/helpers/point';
import Grid, { Point } from '@/lib/grid';

function part1(input: string): number {
  const grid = new Grid(input);
  const partNumberData = getPartNumberData(grid);
  const partNumbers = partNumberData.map(data => data.number);
  return NumberHelper.sum(partNumbers);
}

function part2(input: string): number {
  const grid = new Grid(input);
  const partNumberData = getPartNumberData(grid);
  const gearRatios = grid.points.map(point =>
    getGearRatio(grid, point, partNumberData),
  );
  return NumberHelper.sum(gearRatios);
}

function getGearRatio(
  grid: Grid,
  point: Point,
  partNumberData: PartNumberData[],
): number {
  const isPotentialGear = grid.get(point) === '*';
  if (!isPotentialGear) {
    return 0;
  }

  const neighbours = grid.get8Neighbours(point);

  const partNumbers = partNumberData
    .filter(data =>
      neighbours.some(neighbour =>
        PointHelper.getPointsFromTo(data.from, data.to).some(point =>
          PointHelper.isPointEqual(point, neighbour),
        ),
      ),
    )
    .map(position => position.number);

  if (partNumbers.length !== 2) {
    return 0;
  }

  return NumberHelper.product(partNumbers);
}

interface PartNumberData {
  number: number;
  from: Point;
  to: Point;
}

function getPartNumberData(grid: Grid): PartNumberData[] {
  const partNumberData: PartNumberData[] = [];

  let inProgress: string[] = [];
  const width = grid.width;

  for (const point of grid.points) {
    const value = grid.get(point);
    if (!value) {
      continue;
    }

    const isNumber = NumberHelper.isNumber(value);
    const [x, y] = point;
    const isAtEndOfRow = x === width - 1;

    if (isNumber) {
      inProgress.push(value);
    }

    if (!isAtEndOfRow && isNumber) {
      continue;
    }

    if (inProgress.length > 0) {
      const from: Point = [x - inProgress.length, y];
      const to: Point = [x - 1, y];

      if (isPartNumber(grid, from, to)) {
        const number = parseInt(inProgress.join(''));
        partNumberData.push({ number, from, to });
      }

      inProgress = [];
    }
  }

  return partNumberData;
}

function isPartNumber(grid: Grid, from: Point, to: Point): boolean {
  const points = PointHelper.getPointsFromTo(from, to);
  const neighbours = points
    .flatMap(point => grid.get8Neighbours(point))
    .map(point => grid.get(point));

  return neighbours.some(
    value => value != '.' && !NumberHelper.isNumber(value),
  );
}

export default { part1, part2 };
