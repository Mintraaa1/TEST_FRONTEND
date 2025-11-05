import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
  await page.goto('http://localhost:5173/');
  await page.getByRole('link', { name: 'Join Us' }).click();
  await page.getByRole('link', { name: 'เข้าสู่ระบบ' }).click();
  await page.getByRole('link', { name: 'เข้าสู่ระบบที่นี่' }).click();
  await page.getByRole('textbox', { name: 'อีเมล' }).click();
  await page.getByRole('textbox', { name: 'อีเมล' }).fill('caddie01@gmail.com');
  await page.getByRole('textbox', { name: 'รหัสผ่าน' }).click();
  await page.getByRole('textbox', { name: 'รหัสผ่าน' }).fill('caddie12345678');
  await page.getByRole('button', { name: 'เข้าสู่ระบบ' }).click();
  await page.getByRole('textbox').click();
  await page.getByRole('gridcell', { name: 'Choose วันจันทร์ที่ 17' }).click();
  await page.getByRole('button', { name: '08:30' }).click();
  await page.getByRole('button', { name: 'ยืนยัน' }).click();
  await page.getByRole('button', { name: 'ยืนยัน' }).click();
  await page.getByRole('button', { name: 'ยืนยัน' }).click();
  await page.getByRole('textbox').click();
  await page.getByRole('gridcell', { name: 'Choose วันจันทร์ที่ 17' }).click();
});