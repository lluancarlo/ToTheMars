export class Helper {
    static Capitalize(str: string): string {
        const lower = str.toLowerCase()
        return str.charAt(0).toUpperCase() + lower.slice(1);
    }
}