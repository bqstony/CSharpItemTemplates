using FakeItEasy;
using FluentAssertions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xunit;
using Xunit.Abstractions;

namespace $safeprojectname$
{
	public class XunitTest
    {
        private readonly ITestOutputHelper _testOutput;

        public XunitTest(ITestOutputHelper testOutput)
        {
            _testOutput = testOutput;
        }

        [Fact]
        public void SomethingShouldBeDone()
        {
            // Arrange

            // Act

            // Assert

        }
    }
}
