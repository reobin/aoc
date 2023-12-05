import StringHelper from '@/helpers/string';

describe('StringHelper.splitLines', () => {
  test('should split lines', () => {
    expect(StringHelper.splitLines('a\nb')).toEqual(['a', 'b']);
  });

  test('should remove empty lines', () => {
    expect(StringHelper.splitLines('a\n\nb')).toEqual(['a', 'b']);
  });
});
