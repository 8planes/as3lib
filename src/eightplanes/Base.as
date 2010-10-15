package eightplanes {
    public class Base {
        public static function partial(fn : Function, ...args) : Function {
            return function(...innerArgs) : * {
                return fn.apply(this, args.concat(innerArgs));
            }
        }
    }
}