import PointHelper from '@/helpers/point';

describe('PointHelper.get4Neighbours(point)', () => {
  test('returns the 4 neighbours of a point', () => {
    expect(PointHelper.get4Neighbours([1, 1])).toEqual(
      expect.arrayContaining([
        [1, 0],
        [0, 1],
        [2, 1],
        [1, 2],
      ]),
    );
  });

  test('handles negative coordinates', () => {
    expect(PointHelper.get4Neighbours([0, 0])).toEqual(
      expect.arrayContaining([
        [0, -1],
        [-1, 0],
        [1, 0],
        [0, 1],
      ]),
    );
  });
});

describe('PointHelper.get8Neighbours(point)', () => {
  test('returns the 8 neighbours of a point', () => {
    expect(PointHelper.get8Neighbours([1, 1])).toEqual(
      expect.arrayContaining([
        [0, 0],
        [1, 0],
        [2, 0],
        [0, 1],
        [2, 1],
        [0, 2],
        [1, 2],
        [2, 2],
      ]),
    );
  });

  test('handles negative coordinates', () => {
    expect(PointHelper.get8Neighbours([0, 0])).toEqual(
      expect.arrayContaining([
        [-1, -1],
        [0, -1],
        [1, -1],
        [-1, 0],
        [1, 0],
        [-1, 1],
        [0, 1],
        [1, 1],
      ]),
    );
  });
});

describe('PointHelper.getPointsBetween(point1, point2)', () => {
  test('returns the points between two points', () => {
    expect(PointHelper.getPointsBetween([0, 0], [2, 2])).toEqual(
      expect.arrayContaining([
        [1, 0],
        [2, 0],
        [0, 1],
        [1, 1],
        [2, 1],
        [0, 2],
        [1, 2],
      ]),
    );
  });

  test('handles negative coordinates', () => {
    expect(PointHelper.getPointsBetween([-1, -1], [1, 1])).toEqual(
      expect.arrayContaining([
        [0, 0],
        [1, 0],
        [0, 1],
      ]),
    );
  });
});

describe('PointHelper.getPointsFromTo(point1, point2)', () => {
  test('returns the points between two points including the two points', () => {
    expect(PointHelper.getPointsFromTo([0, 0], [2, 2])).toEqual(
      expect.arrayContaining([
        [0, 0],
        [1, 0],
        [2, 0],
        [0, 1],
        [1, 1],
        [2, 1],
        [0, 2],
        [1, 2],
        [2, 2],
      ]),
    );
  });

  test('handles negative coordinates', () => {
    expect(PointHelper.getPointsFromTo([-1, -1], [1, 1])).toEqual(
      expect.arrayContaining([
        [-1, -1],
        [0, 0],
        [1, 0],
        [0, 1],
        [1, 1],
      ]),
    );
  });
});

describe('PointHelper.isPointEqual(point1, point2)', () => {
  test('returns true if the points are equal', () => {
    expect(PointHelper.isPointEqual([0, 0], [0, 0])).toBe(true);
  });

  test('returns false if the points are not equal', () => {
    expect(PointHelper.isPointEqual([0, 0], [1, 1])).toBe(false);
  });
});
