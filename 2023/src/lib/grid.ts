import PointHelper from '@/helpers/point';
import StringHelper from '@/helpers/string';

/**
 * A 2D point.
 */
export type Point = [number, number];

type GridKey = string;

/**
 * A 2D Grid.
 */
export default class Grid {
  private _grid: Map<GridKey, string>;

  /**
   * Create a new 2D Grid instance from a string.
   *
   * @param input The string to create the grid from.
   *
   * @returns A new Grid instance.
   */
  constructor(input: string) {
    this._grid = new Map();
    const rows = StringHelper.splitLines(input);

    for (let y = 0; y < rows.length; y++) {
      const row = rows[y];
      const columns = row.split('').filter(Boolean);
      for (let x = 0; x < columns.length; x++) {
        this.set([x, y], columns[x]);
      }
    }
  }

  /**
   * Get the value at the given point.
   *
   * @param props.point The point to get the value for.
   * @param [props.defaultValue] The default value to return if the point is not set. Defaults to `undefined`.
   *
   * @returns The value at the given point, or the default value if the point is not set.
   */
  get(point: Point, defaultValue?: string): string {
    return this._grid.get(this.coordinatesToKey(point)) ?? defaultValue;
  }

  /**
   * Set the value at the given point.
   *
   * @param point The point to set the value for.
   * @param value The value to set.
   */
  set(point: Point, value: string) {
    this._grid.set(this.coordinatesToKey(point), value);
  }

  /**
   * Get the list of points in the grid only counting those that have a value.
   *
   * @returns The list of points in the grid.
   */
  get points(): [number, number][] {
    const points = [];

    const iterator = this._grid.keys();
    while (true) {
      const next = iterator.next();
      if (next.done) {
        break;
      }

      points.push(this.keyToCoordinates(next.value));
    }

    return points;
  }

  /**
   * Get the list of values in the grid only counting those that are assigned.
   *
   * @returns The list of values in the grid.
   */
  get values(): string[] {
    const values = [];

    const iterator = this._grid.values();
    while (true) {
      const next = iterator.next();
      if (next.done) {
        break;
      }

      values.push(next.value);
    }

    return values;
  }

  /**
   * Get the minimum x coordinate in the grid.
   *
   * @returns The minimum x coordinate in the grid.
   */
  get minX(): number {
    return this.points.reduce((min, [x, _y]) => Math.min(min, x), Infinity);
  }

  /**
   * Get the maximum x coordinate in the grid.
   *
   * @returns The maximum x coordinate in the grid.
   */
  get maxX(): number {
    return this.points.reduce((max, [x, _y]) => Math.max(max, x), -Infinity);
  }

  /**
   * Get the minimum y coordinate in the grid.
   *
   * @returns The minimum y coordinate in the grid.
   */
  get minY(): number {
    return this.points.reduce((min, [_x, y]) => Math.min(min, y), Infinity);
  }

  /**
   * Get the maximum y coordinate in the grid.
   *
   * @returns The maximum y coordinate in the grid.
   */
  get maxY(): number {
    return this.points.reduce((max, [_x, y]) => Math.max(max, y), -Infinity);
  }

  /**
   * Get the width of the grid.
   *
   * @returns The width.
   */
  get width(): number {
    return this.maxX - this.minX + 1;
  }

  /**
   * Get the height of the grid.
   *
   * @returns The height.
   */
  get height(): number {
    return this.maxY - this.minY + 1;
  }

  /**
   * Print the grid to the console.
   */
  print() {
    console.log(this.toString());
  }

  /**
   * Get 4 neighbours of the given point excluding diagonals. Only keep neighbours that are set.
   *
   * @param point The point to get the 4 neighbours for.
   *
   * @returns The list of neighbours that are set.
   */
  get4Neighbours(point: Point): Point[] {
    const neighbours = PointHelper.get4Neighbours(point);
    return neighbours.filter(point => this.get(point) != null);
  }

  /**
   * Get 8 neighbours of the given point including diagonals. Only keep neighbours that are set.
   *
   * @param point The point to get the 8 neighbours for.
   *
   * @returns The list of neighbours that are set.
   */
  get8Neighbours(point: Point): Point[] {
    const neighbours = PointHelper.get8Neighbours(point);
    return neighbours.filter(point => this.get(point) != null);
  }

  /**
   * Convert the grid to a string representing the 2D grid.
   *
   * @returns The grid as a string.
   */
  toString(): string {
    let output = '';

    const { minX, minY, maxX, maxY } = this;
    for (let y = minY; y <= maxY; y++) {
      for (let x = minX; x <= maxX; x++) {
        output += this.get([x, y], ' ');
      }

      if (y !== maxY) {
        output += '\n';
      }
    }

    return output;
  }

  /**
   * Convert a point to a map key.
   *
   * @param point The point to convert.
   *
   * @returns The map key.
   */
  private coordinatesToKey([x, y]: Point): GridKey {
    return `${x},${y}`;
  }

  /**
   * Convert a map key to a point.
   *
   * @param key The map key to convert.
   *
   * @returns The point.
   */
  private keyToCoordinates(key: GridKey): Point {
    return key.split(',').map(Number) as Point;
  }
}
