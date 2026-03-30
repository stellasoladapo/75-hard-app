import { CHALLENGE_LENGTH } from "../constants/challenge";

export function getDateKey(date = new Date()) {
  const year = date.getFullYear();
  const month = `${date.getMonth() + 1}`.padStart(2, "0");
  const day = `${date.getDate()}`.padStart(2, "0");
  return `${year}-${month}-${day}`;
}

export function parseDateKey(dateKey) {
  const [year, month, day] = dateKey.split("-").map(Number);
  return new Date(year, month - 1, day);
}

export function startOfDay(date) {
  return new Date(date.getFullYear(), date.getMonth(), date.getDate());
}

export function addDays(date, days) {
  const next = new Date(date);
  next.setDate(next.getDate() + days);
  return startOfDay(next);
}

export function daysBetween(start, end) {
  const ms = startOfDay(end).getTime() - startOfDay(start).getTime();
  return Math.floor(ms / 86400000);
}

export function formatLongDate(date) {
  return date.toLocaleDateString(undefined, {
    weekday: "long",
    month: "long",
    day: "numeric",
    year: "numeric",
  });
}

export function formatShortDate(date) {
  return date.toLocaleDateString(undefined, {
    month: "short",
    day: "numeric",
  });
}

export function getChallengeDay(startDate, today = new Date()) {
  const diff = daysBetween(startDate, today) + 1;
  if (diff < 1) {
    return 0;
  }
  return Math.min(diff, CHALLENGE_LENGTH);
}

export function getChallengeDates(startDate) {
  return Array.from({ length: CHALLENGE_LENGTH }, (_, index) => addDays(startDate, index));
}

export function isWithinChallenge(startDate, date = new Date()) {
  const diff = daysBetween(startDate, date);
  return diff >= 0 && diff < CHALLENGE_LENGTH;
}
