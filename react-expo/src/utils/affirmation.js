import { QUOTES } from "../constants/quotes";

export function getDailyAffirmation(date = new Date()) {
  const sourceDate = date instanceof Date ? date : new Date(date);
  const dayIndex = Math.floor(sourceDate.getTime() / (1000 * 60 * 60 * 24));
  return QUOTES[dayIndex % QUOTES.length];
}
