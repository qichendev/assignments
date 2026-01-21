public class GadgetFactory {
    public Gadget createGadget(String type) {
        if (type == null) {
            return null;
        }
        String t = type.toLowerCase();
        if (t.equals("tablet")) {
            return new Tablet();
        }
        if (t.equals("smartwatch")) {
            return new Smartwatch();
        }
        return null;
    }
}