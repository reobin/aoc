import { Point } from '@/lib/grid';

/**
 * Get the 4 neighbours of a point including only horizontal and vertical.
 *
 * @param point The point to get the neighbours for.
 *
 * @returns The list of neighbours
 */
function get4Neighbours([x, y]: Point): Point[] {
  return [
    [x - 1, y],
    [x + 1, y],
    [x, y - 1],
    [x, y + 1],
  ];
}

/**
 * Get the 8 neighbours of a point including diagonals.
 *
 * @param point The point to get the neighbours for.
 *
 * @returns The list of neighbours
 */
function get8Neighbours([x, y]: Point): Point[] {
  return [
    [x - 1, y],
    [x + 1, y],
    [x, y - 1],
    [x, y + 1],
    [x - 1, y - 1],
    [x + 1, y - 1],
    [x - 1, y + 1],
    [x + 1, y + 1],
  ];
}

/**
 * Get all points from a starting point to an ending point including the two points.
 *
 * @param point1 The starting point.
 * @param point2 The ending point.
 *
 * @returns The list of points from the starting point to the ending point.
 */
function getPointsFromTo(point1: Point, point2: Point): Point[] {
  return [point1, ...getPointsBetween(point1, point2), point2];
}

/**
 * Get all points between two points excluding the two points.
 *
 * @param point1 The starting point.
 * @param point2 The ending point.
 *
 * @returns The list of points between the two points.
 */
function getPointsBetween([x1, y1]: Point, [x2, y2]: Point): Point[] {
  const points: Point[] = [];
  for (let x = x1; x <= x2; x++) {
    for (let y = y1; y <= y2; y++) {
      points.push([x, y]);
    }
  }
  return points;
}

/**
 * Check if two points represent the same coordinate.
 *
 * @param point1 The first point to compare.
 * @param point2 The second point to compare.
 *
 * @returns True if the points are equal, false otherwise.
 */
function isPointEqual([x1, y1]: Point, [x2, y2]: Point): boolean {
  return x1 === x2 && y1 === y2;
}

const PointHelper = {
  get4Neighbours,
  get8Neighbours,
  getPointsFromTo,
  getPointsBetween,
  isPointEqual,
};

export default PointHelper;
