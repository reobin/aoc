import Grid from '@/lib/grid';

describe('Grid', () => {
  const input = `123
456`;
  let grid: Grid;

  beforeEach(() => {
    grid = new Grid(input);
  });

  describe('new Grid(input)', () => {
    test('creates a new grid from a string', () => {
      expect(grid.get([0, 0])).toBe('1');
      expect(grid.get([1, 0])).toBe('2');
      expect(grid.get([2, 0])).toBe('3');
      expect(grid.get([0, 1])).toBe('4');
      expect(grid.get([1, 1])).toBe('5');
      expect(grid.get([2, 1])).toBe('6');
      expect(grid.get([3, 1])).toBeUndefined();
    });
  });

  describe('grid.points', () => {
    test('returns the list of points in the grid', () => {
      expect(grid.points).toEqual([
        [0, 0],
        [1, 0],
        [2, 0],
        [0, 1],
        [1, 1],
        [2, 1],
      ]);
    });
  });

  describe('grid.values', () => {
    test('returns the list of values in the grid', () => {
      expect(grid.values).toEqual(['1', '2', '3', '4', '5', '6']);
    });
  });

  describe('grid.minX', () => {
    test('returns the minimum x coordinate in the grid', () => {
      expect(grid.minX).toBe(0);
    });

    test('handles negative x coordinates', () => {
      grid.set([-1, 0], '0');
      expect(grid.minX).toBe(-1);
    });

    test('handles gaps in the x coordinates', () => {
      grid.set([-10, 0], '0');
      expect(grid.minX).toBe(-10);
    });
  });

  describe('grid.maxX', () => {
    test('returns the maximum x coordinate in the grid', () => {
      expect(grid.maxX).toBe(2);
    });

    test('handles gaps in the x coordinates', () => {
      grid.set([10, 0], '0');
      expect(grid.maxX).toBe(10);
    });
  });

  describe('grid.minY', () => {
    test('returns the minimum y coordinate in the grid', () => {
      expect(grid.minY).toBe(0);
    });

    test('handles negative y coordinates', () => {
      grid.set([0, -1], '0');
      expect(grid.minY).toBe(-1);
    });

    test('handles gaps in the y coordinates', () => {
      grid.set([0, -10], '0');
      expect(grid.minY).toBe(-10);
    });
  });

  describe('grid.maxY', () => {
    test('returns the maximum y coordinate in the grid', () => {
      expect(grid.maxY).toBe(1);
    });

    test('handles gaps in the y coordinates', () => {
      grid.set([0, 10], '0');
      expect(grid.maxY).toBe(10);
    });
  });

  describe('grid.width', () => {
    test('returns the width of the grid', () => {
      expect(grid.width).toBe(3);
    });

    test('handles negative x coordinates', () => {
      grid.set([-1, 0], '0');
      expect(grid.width).toBe(4);
    });

    test('handles gaps in the x coordinates', () => {
      grid.set([10, 0], '0');
      expect(grid.width).toBe(11);
    });
  });

  describe('grid.height', () => {
    test('returns the height of the grid', () => {
      expect(grid.height).toBe(2);
    });

    test('handles negative y coordinates', () => {
      grid.set([0, -1], '0');
      expect(grid.height).toBe(3);
    });

    test('handles gaps in the y coordinates', () => {
      grid.set([0, 10], '0');
      expect(grid.height).toBe(11);
    });
  });

  describe('grid.get8Neighbours(point)', () => {
    test('returns the defined neighbours checking 8 directions of a point', () => {
      // 1_3
      // 456
      expect(grid.get8Neighbours([1, 0])).toEqual(
        expect.arrayContaining([
          [0, 0],
          [2, 0],
          [0, 1],
          [1, 1],
          [2, 1],
        ]),
      );

      // 123
      // 45_
      expect(grid.get8Neighbours([2, 1])).toEqual(
        expect.arrayContaining([
          [1, 0],
          [2, 0],
          [1, 1],
        ]),
      );
    });
  });

  describe('grid.get4Neighbours(point)', () => {
    test('returns the defined neighbours checking 4 directions of a point', () => {
      // 1_3
      // 456
      expect(grid.get4Neighbours([1, 0])).toEqual(
        expect.arrayContaining([
          [0, 0],
          [2, 0],
          [1, 1],
        ]),
      );

      // 123
      // 45_
      expect(grid.get4Neighbours([2, 1])).toEqual(
        expect.arrayContaining([
          [2, 0],
          [1, 1],
        ]),
      );
    });
  });

  describe('grid.toString()', () => {
    test('prints exactly the input when no changes are made', () => {
      expect(grid.toString()).toEqual(input);
    });

    test('prints the grid with changes', () => {
      grid.set([0, 0], '0');
      expect(grid.toString()).toEqual(`023
456`);
    });

    test('fills in gaps with spaces', () => {
      grid.set([4, 0], '0');
      expect(grid.toString()).toEqual(`123 0
456  `);
    });
  });
});
