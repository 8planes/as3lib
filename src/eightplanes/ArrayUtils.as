package eightplanes {
    /**
     * Borrows heavily from array.js in Google Closure library.
     */
    public class ArrayUtils {
        
        public static function defaultCompare(a : *, b : *) : int {
            return a > b ? 1 : a < b ? -1 : 0;
        }

        /**
         * Inserts a value into a sorted array. The array is not modified if 
         * the value is already present.
         * @param arr The array to modify.
         * @param value The object to insert.
         * @param compareFn Comparison function. Should take two arguments 
         *     to compare, and return a negative integer, zero, or positive 
         *     integer depending on whether the first argument is less than, 
         *     equal to, or greater than the second.
         * @return True if element was inserted.
         */
        public static function binaryInsert(arr : Array, value : *, compareFn : Function = null) : Boolean {
            var index : int = binarySearch(arr, value, compareFn);
            if (index < 0) {
                insertAt(arr, value, -(index + 1));
                return true;
            }
            else
                return false;
        }
        
        public static function insertAt(arr : Array, value: *, index : int) : void {
            arr.splice(index, 0, value);
        }
        
        public static function binarySearch(arr : Array, target : *, compareFn : Function) : int {
            return binarySelect(arr, 
                Base.partial(compareFn || defaultCompare, target));
        }
        
        public static function binarySelect(arr : Array, evaluator : Function) : int {
            var left : int = 0; // inclusive
            var right : int = arr.length; // exclusive
            var found : Boolean = false;
            while (left < right) {
                var middle : int = (left + right) >> 1;
                var evalResult : int = evaluator(arr[middle]);
                if (evalResult > 0)
                    left = middle + 1;
                else {
                    right = middle;
                    found = !evalResult;
                }
            }
            return found ? left : ~left;
        }
        
        public static function removeIf(arr : Array, predicate : Function) : Boolean {
            var i : int = findIndex(arr, predicate);
            if (i >= 0) {
                removeAt(arr, i);
                return true;
            }
            return false;
        }
        public static function findIndex(arr : Array, predicate : Function) : int {
            for (var i : int = 0; i < arr.length; i++)
                if (predicate(arr[i]))
                    return i;
            return -1;
        }
        public static function removeAt(arr : Array, index : int) : Boolean {
            return arr.splice(arr, index, 1).length == 1;
        }
    }
}