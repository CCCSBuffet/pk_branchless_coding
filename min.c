
int min1(int a, int b) {
	if (a < b)
		return a;
	else
		return b;
}

int min2(int a, int b) {
	return a * (a < b) + b * (b <= a);
}

void ToUpper(char *s, int count)
{
	for (int i = 0; i < count; i++)
	{
		if (s[i] >= 'a' && s[i] <= 'z')
			s[i] -= 32;
	}
}

void ToUpper2(char *s, int count)
{
	for (int i = 0; i < count; i++)
	{
		s[i] = 
			s[i] * !(s[i] >= 'a' && s[i] <= 'z') +
			(s[i] - 32) * (s[i] >= 'a' && s[i] <= 'z');
	}
}

void ToUpper3(char *s, int count)
{
	for (int i = 0; i < count; i++)
	{
		s[i] -= 32 * (s[i] >= 'a' && s[i] <= 'z');
	}
}